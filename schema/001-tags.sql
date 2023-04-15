DROP TABLE IF EXISTS tagging;

DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL,
	slug TEXT,
	created_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	updated_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	UNIQUE ('name', 'slug')
);

DROP TRIGGER IF EXISTS trigger_tags_updated_at;
CREATE TRIGGER trigger_tags_updated_at AFTER UPDATE ON articles
BEGIN
    UPDATE tags SET updated_at = DATETIME('now', 'localtime') WHERE rowid == NEW.rowid;
END;
