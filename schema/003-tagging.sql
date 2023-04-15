DROP TABLE IF EXISTS tagging;
CREATE TABLE tagging (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	article_id INTEGER,
	tag_id INTEGER,
	FOREIGN KEY (article_id) REFERENCES articles (id),
	FOREIGN KEY (tag_id) REFERENCES tags (id)
);
