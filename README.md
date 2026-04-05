How to Run (Setup Database & Seed Test Data)

- docker-compose up --build

Framework

- I have selected Node.js + Express for its lightweight architecture, strong ecosystem, and our proficiency with the stack, enabling fast development, scalability, and ease of maintenance in production environments
- I use Prisma ORM because it provides strong type safety, excellent developer experience, and simplified database migrations. It reduces runtime errors and improves productivity, especially in a TypeScript-based backend with complex data models and multi-tenant architecture.

Technology choice

- The system can be deployed on either EC2 or ECS, as the application is still in its early stage and the number of customers is not yet large. However, the architecture is designed with future scalability in mind.
- A Multi-Tenant architecture is being prepared to support multiple customers. All data will be associated with a tenant_id, and JWT will be used alongside to validate and identify tenants securely
- When the number of customers grows significantly or the system evolves into a B2B SaaS product, the platform can be migrated to EKS, as the system is already designed to be compatible with ECS-based containerization
- A queue system such as AWS SQS is used for handling heavy event workloads (e.g., telemetry and event processing), as the expected data volume is high and near real-time processing is required
- Logging and monitoring are implemented using AWS CloudWatch to track logs, errors, and system metrics
- To support future scalability, the system may be enhanced with
  - Read replicas for separating read and write workloads
  - Redis caching to reduce database load and improve performance

API contract

Success

```bash
{
   "success": true, (true/false)
   "data": {},
   "message": {}
}
```

Error

```bash
{
   "success": true, (true/false)
   "error": {
      "code": "VALIDATION_ERROR",
      "message": "Invalid request payload"
   }
}
```

Pagination approach

```bash
GET vehicle?page=1&limit=20&sort=createdAt&order=desc&vehicle_name=john
```

Authentication & multi-tenancy design
Use Prisma middleware to detect first and query tenent_id in service

```bash
tenant_id
```

Example Tenent approach

```bash
Tenent

id
name
plan (free | pro | etc)
created_at

Users

id
tenant_id
name
role

Vehicles

id
tenant_id
vehicle_name

Event

id
tenant_id
event_type
event_name
```
