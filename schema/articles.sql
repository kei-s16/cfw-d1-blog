DROP TABLE IF EXISTS articles;
CREATE TABLE articles (
	id INT,
	title TEXT,
	body TEXT,
	created_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	updated_at TEXT NOT NULL DEFAULT (DATETIME('now', 'localtime')),
	PRIMARY KEY ('id')
);

DROP TRIGGER IF EXISTS trigger_article_updated_at;
CREATE TRIGGER trigger_article_updated_at AFTER UPDATE ON articles
BEGIN
    UPDATE articles SET updated_at = DATETIME('now', 'localtime') WHERE rowid == NEW.rowid;
END;
