-- AddForeignKey
ALTER TABLE "unsafe_event" ADD CONSTRAINT "unsafe_event_telemetry_id_fkey" FOREIGN KEY ("telemetry_id") REFERENCES "vehicle_telemetry"("id") ON DELETE SET NULL ON UPDATE CASCADE;
