export interface Env {
  DB: D1Database;
}

export default {
  async fetch(request: Request, env: Env) {
    const { pathname } = new URL(request.url);

    if (pathname === "/api/tables/show") {
      const { results } = await env.DB.prepare(
        "select name from sqlite_master where type='table'"
      )
        .bind()
        .all();
      return Response.json(results);
    }

    return new Response(
      "Hello World!"
    );
  },
};
