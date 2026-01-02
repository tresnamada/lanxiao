import { UserRole } from "@/app/generated/prisma/enums";
import { type DefaultSession } from "next-auth";

export type ExtendedUser = DefaultSession["user"] & {
  role: UserRole;
  isOnboarded: boolean;
};

declare module "next-auth" {
  interface Session {
    user: ExtendedUser;
  }
}
