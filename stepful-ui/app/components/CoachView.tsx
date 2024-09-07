import { client, Slot } from 'api/client';
import moment from 'moment'
import { useCallback, useEffect, useState } from 'react';
import { Calendar, momentLocalizer } from 'react-big-calendar'

const localizer = momentLocalizer(moment)

interface Event extends Omit<Omit<Slot, 'start'>, 'end'> {
  start: Date
  end: Date
}

function slotToEvent(slot: Slot): Event {
  return { ...slot, start: new Date(slot.start), end: new Date(slot.end) };
}

async function listSlots() {
  const { data, error } = await client.GET("/coaches/{coach_id}/slots", {
    params: {
      path: { coach_id: "1" },
    },
  });
  return { slots: data?.data, error };
}

async function createSlot(start: Date) {
  const { data, error } = await client.POST("/coaches/{coach_id}/slots", {
    params: {
      path: { coach_id: "1" },
    },
    body: { slot: { start: start.toString() } },
  });
  return { slot: data?.data, error };
}

export default function CoachView() {
  const [slots, setSlots] = useState<Slot[]>([]);

  const handleSelectSlot = useCallback(
    ({ start }: { start: Date }) => {
      createSlot(start).then(() => {
        listSlots().then(({ slots }) => {
          if (slots) setSlots(slots);
        });
      });
    },
    [setSlots]
  )

  const handleSelectEvent = useCallback(
    (event: Event) => {
      if (event.phone) {
        window.alert(`Call at ${event.phone}.`);
      } else {
        window.alert('No one to call yet!');
      };
    },
    []
  )

  useEffect(() => {
    const fetchData = async () => {
      const { slots } = await listSlots();

      if (slots) {
        setSlots(slots);
      } else {
        window.alert('Could not fetch slots!');
      }
    }

    fetchData();
  }, [])

  const events: Event[] = slots.map(slotToEvent);

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
        onSelectSlot={handleSelectSlot}
        selectable
      />
    </div>
  );
}
