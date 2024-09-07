import { client, Coach, Slot } from 'api/client';
import moment from 'moment'
import { useCallback, useEffect, useState } from "react";
import { Calendar, momentLocalizer } from 'react-big-calendar'

const localizer = momentLocalizer(moment)

interface Event extends Omit<Omit<Slot, 'start'>, 'end'> {
  start: Date
  end: Date
}

function slotToEvent(slot: Slot): Event {
  return { ...slot, start: new Date(slot.start), end: new Date(slot.end) };
}

async function listCoaches() {
  const { data, error } = await client.GET("/coaches");
  return { coaches: data?.data, error };
}

async function listSlots() {
  const { data, error } = await client.GET("/students/{student_id}/slots", {
    params: {
      path: { student_id: "3" },
    },
  });
  return { slots: data?.data, error };
}

async function joinSlot(event: Event) {
  const { data, error } = await client.PUT("/students/{student_id}/slots/{slot_id}", {
    params: {
      path: { student_id: "3", slot_id: String(event.id) },
    },
  });
  return { slots: data?.data, error };
}

export default function StudentView() {
  const [coaches, setCoaches] = useState<Coach[]>([]);
  const [slots, setSlots] = useState<Slot[]>([]);

  useEffect(() => {
    const fetchData = async () => {
      const { coaches } = await listCoaches();
      const { slots } = await listSlots();

      if (coaches) {
        setCoaches(coaches);
      } else {
        window.alert('Could not fetch coaches!');
      }
      if (slots) {
        setSlots(slots);
      } else {
        window.alert('Could not fetch slots!');
      }
    }

    fetchData();
  }, [])

  const events: Event[] = slots.map(slotToEvent);
  coaches.forEach(coach => {
    coach.slots.forEach(slot => events.push(slotToEvent(slot)));
  })

  const handleSelectEvent = useCallback(
    (event: Event) => {
      if (event.phone) {
        window.alert(`Call at ${event.phone}.`);
      } else {
        joinSlot(event).then(() => {
          listCoaches().then(({ coaches }) => {
            if (coaches) {
              setCoaches(coaches);
            } else {
              window.alert('Could not fetch coaches!');
            }
          });

          listSlots().then(({ slots }) => {
            if (slots) {
              setSlots(slots);
            } else {
              window.alert('Could not fetch slots!');
            }
          });
        });
      };
    },
    []
  )

  return (
    <div>
      <Calendar
        localizer={localizer}
        events={events}
        startAccessor="start"
        endAccessor="end"
        style={{ height: 750 }}
        defaultView="week"
        onSelectEvent={handleSelectEvent}
        selectable
      />
    </div>
  );
}
