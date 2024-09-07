import type { MetaFunction } from "@remix-run/node";

import { useState } from "react";
import CoachView from "~/components/CoachView";
import StudentView from "~/components/StudentView";

import 'react-big-calendar/lib/css/react-big-calendar.css'

export const meta: MetaFunction = () => {
  return [
    { title: "a Coaching Conundrum" },
    { name: "description", content: "a Coaching Conundrum" },
  ];
};

export default function Index() {
  const [isCoachView, setIsCoachView] = useState(true);

  const toggleCoachView = () => {
    setIsCoachView(!isCoachView);
  }

  return (
    <div className="p-8">
      <div className="flex flex-row justify-between mb-4">
        <h1 className="text-xl">
          {isCoachView ? 'Coach view' : 'Student view'}
        </h1>

        <button onClick={toggleCoachView} className="animate-pulse">
          {isCoachView ? 'See student view' : 'See coach view'}
        </button>
      </div>

      {isCoachView ? <CoachView /> : <StudentView /> }
    </div>
  );
}
