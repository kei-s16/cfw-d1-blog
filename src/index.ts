import { Hono } from 'hono';
import type { Database } from '@cloudflare/d1';

type Bindings = {
  DB: Database // Cloudflare D1
}

const app = new Hono<{Bindings: Bindings}>();

app.get('/', () => {
  return new Response(
    "Hello World!"
  );
});

app.get('/api/tables/show', async (context) => {
  const { results } = await context.env.DB.prepare(
    "select name from sqlite_master where type='table'"
  )
    .bind()
    .all();
  return Response.json(results);
});

export default app;
