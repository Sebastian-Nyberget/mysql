import { Hono } from "hono";
import { PrismaClient } from "@prisma/client";
import { compare, hash } from "bcryptjs";
import { zValidator } from "@hono/zod-validator";
import { loginSchema, signupSchema } from "../schemas";

const app = new Hono();
const prisma = new PrismaClient();

app.post(
  "/signup",
  zValidator("json", signupSchema),
  async (c) => {
    try {
      console.log("Incoming request body:", await c.req.text());

      const { fornavn, email, password } = await c.req.json();

      if (!fornavn || !email || !password) {
        return c.json({ error: "Missing required fields" }, 400);
      }

      const existingUser = await prisma.medlemmer.findUnique({ where: { email } });
      if (existingUser) {
        return c.json({ error: "User already exists" }, 400);
      }

      const hashedPassword = await hash(password, 10);
      const user = await prisma.medlemmer.create({
        data: {
          fornavn,
          email,
          password: hashedPassword,
          medlemskap_type: "Basic",
        },
      });

      return c.json({ message: "User created", user });
    } catch (error) {
      console.error("Signup error:", error);
      return c.json({ error: "Server error" }, 500);
    }
  }
)

app.post(
  "/login",
  zValidator("json", loginSchema),
  async (c) => {
    const { email, password } = await c.req.json();

    const member = await prisma.medlemmer.findUnique({ where: { email } });
    if (!member) return c.json({ error: "Invalid credentials" }, 401);

    const isPasswordValid = await compare(password, member.password);
    if (!isPasswordValid) return c.json({ error: "Invalid credentials" }, 401);

    return c.json({ message: "Login successful", member });
  }
)

export default app;