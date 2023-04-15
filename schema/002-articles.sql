DROP TABLE IF EXISTS tagging;

DROP TABLE IF EXISTS articles;
CREATE TABLE articles (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	title TEXT NOT NULL DEFAULT ('tmp/draft'),
	body TEXT,
	slug TEXT,
	created_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	updated_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	UNIQUE ('slug')
);

DROP TRIGGER IF EXISTS trigger_article_updated_at;
CREATE TRIGGER trigger_article_updated_at AFTER UPDATE ON articles
BEGIN
    UPDATE articles SET updated_at = DATETIME('now', 'localtime') WHERE rowid == NEW.rowid;
END;
