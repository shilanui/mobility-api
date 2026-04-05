How to Run (Setup Database & Seed Test Data)

- docker-compose up --build

Framework

- I have selected Node.js + Express for its lightweight architecture, strong ecosystem, and our proficiency with the stack, enabling fast development, scalability, and ease of maintenance in production environments

Technology choice

- The system can be deployed on either EC2 or ECS, as the application is still in its early stage and the number of customers is not yet large. However, the architecture is designed with future scalability in mind.
- A Multi-Tenant architecture is being prepared to support multiple customers. All data will be associated with a tenant_id, and JWT will be used alongside to validate and identify tenants securely
- When the number of customers grows significantly or the system evolves into a B2B SaaS product, the platform can be migrated to EKS, as the system is already designed to be compatible with ECS-based containerization
- A queue system such as AWS SQS is used for handling heavy event workloads (e.g., telemetry and event processing), as the expected data volume is high and near real-time processing is required
- Logging and monitoring are implemented using AWS CloudWatch to track logs, errors, and system metrics
- To support future scalability, the system may be enhanced with
  - Read replicas for separating read and write workloads
  - Redis caching to reduce database load and improve performance
