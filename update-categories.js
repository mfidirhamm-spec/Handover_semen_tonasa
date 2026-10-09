const { Pool } = require('pg');

const pool = new Pool({
  user: process.env.DB_USER || 'postgres',
  host: process.env.DB_HOST || 'localhost',
  database: process.env.DB_NAME || 'inventaris_tonasa',
  password: process.env.DB_PASSWORD || '123',
  port: process.env.DB_PORT ? parseInt(process.env.DB_PORT) : 5432,
});

async function updateCategories() {
  try {
    const client = await pool.connect();
    
    console.log("Updating 'Peralatan' -> 'Perlengkapan'...");
    await client.query("UPDATE categories SET name = 'Perlengkapan' WHERE name = 'Peralatan'");
    
    console.log("Updating 'Mesin' -> 'Mesin dan Peralatan'...");
    await client.query("UPDATE categories SET name = 'Mesin dan Peralatan' WHERE name = 'Mesin'");

    console.log("Ensuring 'Aset Tak Berwujud' exists...");
    const res = await client.query("SELECT * FROM categories WHERE name = 'Aset Tak Berwujud'");
    if (res.rows.length === 0) {
      await client.query("INSERT INTO categories (name) VALUES ('Aset Tak Berwujud')");
      console.log("Inserted 'Aset Tak Berwujud'.");
    } else {
      console.log("'Aset Tak Berwujud' already exists.");
    }
    
    const finalRes = await client.query("SELECT * FROM categories");
    console.log("Final categories:");
    console.table(finalRes.rows);

    client.release();
    pool.end();
  } catch (e) {
    console.error("Error updating categories:", e);
    pool.end();
  }
}

updateCategories();
