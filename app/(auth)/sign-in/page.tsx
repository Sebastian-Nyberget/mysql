import LoginForm from "@/features/auth/components/sign-in-card";

export default function LoginPage() {
  return (
    <div className="max-w-md mx-auto mt-10">
      <h1 className="text-2xl font-bold">Login</h1>
      <LoginForm />
    </div>
  );
}