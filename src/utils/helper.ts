export const isValidId = (id: any) => {
  const num = Number(id);
  return !isNaN(num) && num > 0;
};

export const isValidSeverity = (severity: any) => {
  return ["LOW", "MEDIUM", "HIGH"].includes(severity);
};
