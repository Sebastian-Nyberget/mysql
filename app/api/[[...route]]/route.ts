import { Hono } from "hono";
import auth from '@/features/auth/server/route'

const app = new Hono().basePath('/api')

// eslint-disable-next-line @typescript-eslint/no-unused-vars
const routes = app
  .route("/auth", auth)

export type AppType = typeof routes;