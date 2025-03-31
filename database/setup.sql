CREATE TABLE IF NOT EXISTS url_mappings (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    original_url TEXT NOT NULL UNIQUE,
    short_url TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE UNIQUE index if not EXISTS idx_url_original ON url_mappings using hash(original_url);
CREATE UNIQUE index if not EXISTS idx_url_short ON url_mappings using hash(short_url);