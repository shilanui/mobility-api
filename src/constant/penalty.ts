export const PENALTY: Record<
  "SPEEDING" | "BRAKING" | "ACCEL",
  Partial<Record<Severity, number>>
> = {
  SPEEDING: { LOW: 1, MEDIUM: 3, HIGH: 5 },
  BRAKING: { MEDIUM: 2, HIGH: 4 },
  ACCEL: { MEDIUM: 2, HIGH: 4 },
};

export type Severity = "LOW" | "MEDIUM" | "HIGH";
