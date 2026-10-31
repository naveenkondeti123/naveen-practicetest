
How database connections work blue/green aks infra upgrade
In a typical enterprise architecture:
- V1 runs in the Blue environment.
- V2 runs in the Green environment.
- Both environments connect to the same production Azure Database for PostgreSQL primary database.
- Each version has its own pods, services, and possibly its own connection pool.
- Traffic is switched from V1(100%) to V2(0%) only after Green passes testing.

Important: You normally do not create a separate database for V2 just because you're deploying a new application version.
What happens during rollback?
Suppose V2 is deployed, and users report a problem.
1. Ingress / Load Balancer switches traffic back to Blue (V1).
2. V1 pods resume handling user requests.
3. Both versions still connect to the same database.
4. User data written by V2 remains in that database.
No data is lost simply because you roll back the application pods.

However, there is one major condition: the database schema must remain compatible with V1.
Database schema compatibility (very important)
Imagine V2 adds a new column:
* ALTER TABLE users ADD COLUMN phone_number VARCHAR(20);
This is usually backward compatible: V1 can continue working without using the new column.(because v2 will add a new cloumn so v1 can use the data still no alter/dlete/drop) 

But if V2 does this:  * ALTER TABLE users DROP COLUMN email; (v1 cause issue u are removing/chnage the column not backward compatible v1 req email coloumn wich is deleted by v2)
V1 may fail immediately after rollback because it still expects email.

Enterprise teams use the Expand → Migrate → Contract pattern:
1. Expand: Add new tables/columns without removing old ones.
2. Migrate: Deploy V2, move data gradually, and support both old and new schemas.
3. Contract: Remove obsolete columns only after V1 is no longer needed and rollback is no longer required.
This is what makes application rollback safe.

canary app deployment (new feature or image deploy to some percentage users)
Component	Stable V1	Canary V2
Traffic	90%	10%
Pods		Old version	New version
Database	Same primary DB	Same primary DB
Read/write	Yes	Yes

stable pods v1(90%) and csnary pods v2(10%) still both connect to same primary db 
For example:
- User A lands on V1 → reads/writes PostgreSQL.
- User B lands on V2 → reads/writes that same PostgreSQL.
- User C lands on V1 → writes to PostgreSQL.
- User D lands on V2 → writes to PostgreSQL.
There is no automatic data synchronization between two application versions because there is only one authoritative database.
What happens if V2 fails?
Suppose the canary starts producing errors.
1. Stop routing traffic to V2 (10% → 0%).
2. V1 receives 100% of traffic.
3. V2 pods are removed or rolled back.
4. Any database writes that V2 already committed remain in PostgreSQL.
Again, safe rollback depends on backward-compatible database changes. A V2 transaction that already successfully committed is not undone by rolling back the pods.

