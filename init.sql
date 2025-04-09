
SELECT 'Running init.sql';

CREATE TABLE IF NOT EXISTS url_mappings (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    original_url TEXT NOT NULL UNIQUE,
    short_url TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Ensure uniqueness (btree supports UNIQUE)
CREATE UNIQUE INDEX IF NOT EXISTS idx_url_original_btree ON url_mappings(original_url);
CREATE UNIQUE INDEX IF NOT EXISTS idx_url_short_btree ON url_mappings(short_url);

-- Add separate hash indexes for constant-time lookups
CREATE INDEX IF NOT EXISTS idx_url_original_hash ON url_mappings USING hash(original_url);
CREATE INDEX IF NOT EXISTS idx_url_short_hash ON url_mappings USING hash(short_url);

