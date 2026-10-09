const fs = require('fs');
const db = require('./lib/db');

async function seedDatabase() {
  console.log("Memulai proses seeding/import database...");
  try {
    await new Promise(resolve => setTimeout(resolve, 1500));
    if (!fs.existsSync('database_backup.json')) {
        console.error("File database_backup.json tidak ditemukan!");
        process.exit(1);
    }
    
    const backup = JSON.parse(fs.readFileSync('database_backup.json', 'utf8'));
    const client = await db.pool.connect();

    // 1. Seed Users
    if (backup.users && backup.users.length > 0) {
        for (const u of backup.users) {
            await client.query(
                "INSERT INTO users (id, name, email, password, role, is_deleted) VALUES ($1, $2, $3, $4, $5, $6) ON CONFLICT (id) DO NOTHING",
                [u.id, u.name, u.email, u.password, u.role, u.is_deleted]
            );
        }
        await client.query("SELECT setval(pg_get_serial_sequence('users', 'id'), coalesce(max(id), 0) + 1, false) FROM users;");
        console.log("✅ Users diimpor.");
    }

    // 2. Seed Categories
    if (backup.categories && backup.categories.length > 0) {
        for (const c of backup.categories) {
            await client.query(
                "INSERT INTO categories (id, name) VALUES ($1, $2) ON CONFLICT (id) DO NOTHING",
                [c.id, c.name]
            );
        }
        await client.query("SELECT setval(pg_get_serial_sequence('categories', 'id'), coalesce(max(id), 0) + 1, false) FROM categories;");
        console.log("✅ Categories diimpor.");
    }

    // 3. Seed Assets
    if (backup.assets && backup.assets.length > 0) {
        for (const a of backup.assets) {
            await client.query(`
                INSERT INTO assets (
                    id, asset_number, name, category_id, land_area, equipment_number, 
                    location, location_grup, image_url, function_status, performance_status,
                    created_by, status_approval, is_deleted, created_at,
                    lease_tenant, lease_start_date, lease_end_date, lease_reminder_sent
                ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19)
                ON CONFLICT (id) DO NOTHING
            `, [
                a.id, a.asset_number, a.name, a.category_id, a.land_area, a.equipment_number,
                a.location, a.location_grup, a.image_url, a.function_status, a.performance_status,
                a.created_by, a.status_approval, a.is_deleted, a.created_at,
                a.lease_tenant, a.lease_start_date, a.lease_end_date, a.lease_reminder_sent
            ]);
        }
        await client.query("SELECT setval(pg_get_serial_sequence('assets', 'id'), coalesce(max(id), 0) + 1, false) FROM assets;");
        console.log("✅ Assets diimpor.");
    }

    // 4. Seed Asset History
    if (backup.asset_history && backup.asset_history.length > 0) {
        for (const h of backup.asset_history) {
            await client.query(
                "INSERT INTO asset_history (id, asset_id, changed_by, action, changes, changed_at) VALUES ($1, $2, $3, $4, $5, $6) ON CONFLICT (id) DO NOTHING",
                [h.id, h.asset_id, h.changed_by, h.action, h.changes, h.changed_at]
            );
        }
        await client.query("SELECT setval(pg_get_serial_sequence('asset_history', 'id'), coalesce(max(id), 0) + 1, false) FROM asset_history;");
        console.log("✅ Asset History diimpor.");
    }

    client.release();
    console.log("🎉 Seeding / Import Database Selesai!");
    process.exit(0);
  } catch (err) {
    console.error("❌ Error seeding database:", err);
    process.exit(1);
  }
}

seedDatabase();
