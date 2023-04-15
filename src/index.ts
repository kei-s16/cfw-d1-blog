import { Hono } from 'hono';
import type { Database } from '@cloudflare/d1';

export interface Env {
  DB: Database;
}

// TODO: Envに型エラーが出るので直す
const app = new Hono<Env>();

app.get('/', () => {
  return new Response(
    "Hello World!"
  );
});

// TODO: contextに型エラーが出るので直す
app.get('/api/tables/show', async (context) => {
  const { results } = await context.env.DB.prepare(
    "select name from sqlite_master where type='table'"
  )
    .bind()
    .all();
  return Response.json(results);
});

export default app;
