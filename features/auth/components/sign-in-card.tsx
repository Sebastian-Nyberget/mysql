"use client";

import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import axios, { AxiosError } from "axios";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { useState } from "react";
import { Card, CardContent, CardHeader } from "@/components/ui/card";

const loginSchema = z.object({
  email: z.string().email("Invalid email"),
  password: z.string().min(6, "Password must be at least 6 characters"),
});

export default function SignInCard() {
  const [message, setMessage] = useState("");
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<z.infer<typeof loginSchema>>({
    resolver: zodResolver(loginSchema),
  });

  const onSubmit = async (data: unknown) => {
    try {
      const res = await axios.post("/api/auth/login", data);
      setMessage(res.data.message);
    } catch (error: unknown) {
      const axiosError = error as AxiosError<{ error: string }>;
      setMessage(axiosError.response?.data?.error || "Login failed");
    }
  };

  return (
    <Card>
      <CardHeader>
        Login
      </CardHeader>
      <CardContent>
        <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
          <Input {...register("email")} type="email" placeholder="Email" />
          {errors.email && <p className="text-red-500">{errors.email.message}</p>}
  
          <Input {...register("password")} type="password" placeholder="Passord" />
          {errors.password && <p className="text-red-500">{errors.password.message}</p>}
  
          <Button type="submit">Login</Button>
          {message && <p>{message}</p>}
        </form>
      </CardContent>
    </Card>
  );
}
