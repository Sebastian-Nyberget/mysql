"use client";

import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import axios, { AxiosError } from "axios";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { useState } from "react";
import { signupSchema } from "../schemas";
import { Card, CardContent, CardHeader } from "@/components/ui/card";

export default function SignUpCard() {
  const [message, setMessage] = useState("");
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<z.infer<typeof signupSchema>>({
    resolver: zodResolver(signupSchema),
  });  

  const onSubmit = async (data: z.infer<typeof signupSchema>) => {
    console.log("Submitting data:", data);
  
    try {
      const res = await axios.post("/api/auth/signup", data);
      setMessage(res.data.message);
    } catch (error: unknown) {
      const axiosError = error as AxiosError<{ error: string }>;
      console.error("Signup error:", axiosError.response?.data);
      setMessage(axiosError.response?.data?.error || "Signup failed");
    }
  };
  

  return (
    <Card>
      <CardHeader className="font-bold text-2xl">
        Sign Up
      </CardHeader>
      <CardContent>
        <form onSubmit={handleSubmit(onSubmit)} className="space-y-4">
          <div>
            <Input {...register("fornavn")} placeholder="Fornavn" />
            {errors.fornavn && <p className="text-red-500">{errors.fornavn.message}</p>}
          </div>
          <div>
            <Input {...register("etternavn")} placeholder="Etternavn" />
            {errors.fornavn && <p className="text-red-500">{errors.fornavn.message}</p>}
          </div>
          <div>
            <Input {...register("email")} type="email" placeholder="Email" />
            {errors.email && <p className="text-red-500">{errors.email.message}</p>}
          </div>
          <div>
            <Input {...register("password")} type="password" placeholder="Passord" />
            {errors.password && <p className="text-red-500">{errors.password.message}</p>}
          </div>
          <Button type="submit">Sign Up</Button>
          {message && <p>{message}</p>}
        </form>
      </CardContent>
    </Card>
  );
}