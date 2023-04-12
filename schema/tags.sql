DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
	id INT,
	name TEXT,
	created_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	updated_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	PRIMARY KEY ('id')
);

DROP TRIGGER IF EXISTS trigger_tags_updated_at;
CREATE TRIGGER trigger_tags_updated_at AFTER UPDATE ON articles
BEGIN
    UPDATE tags SET updated_at = DATETIME('now', 'localtime') WHERE rowid == NEW.rowid;
END;
