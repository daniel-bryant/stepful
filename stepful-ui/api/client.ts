import createClient from "openapi-fetch";
import type { components, paths } from "./schema";

export const client = createClient<paths>({
  baseUrl: "http://localhost:3000/",
});

export type Coach = components["schemas"]["Coach"];
export type Slot = components["schemas"]["Slot"];
export type Student = components["schemas"]["Student"];
