"use client";

import { useEffect, useState } from "react";
import { Medlem } from "@/types/medlemmer";

export default function MedlemmerPage() {
  const [medlemmer, setMedlemmer] = useState<Medlem[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch("/api/medlemmer")
      .then((res) => res.json())
      .then((data) => {
        setMedlemmer(data);
        setLoading(false);
      })
      .catch((err) => console.error("Error fetching medlemmer:", err));
  }, []);

  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold mb-4">Medlemmer</h1>
      {loading ? (
        <p>Loading...</p>
      ) : (
        <ul className="space-y-2">
          {medlemmer.map((medlem) => (
            <li key={medlem.id} className="p-2 border rounded-md">
              {medlem.fornavn} - {medlem.email}
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
