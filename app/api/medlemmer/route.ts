/* eslint-disable @typescript-eslint/no-unused-vars */
import { NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export async function GET() {
  try {
    const medlemmer = await prisma.medlemmer.findMany();
    return NextResponse.json(medlemmer, { status: 200 });
  } catch (error) {
    return NextResponse.json({ error: "Failed to fetch medlemmer" }, { status: 500 });
  }
}
