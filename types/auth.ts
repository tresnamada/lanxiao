import { UserRole } from "@/app/generated/prisma/enums";

export interface RegisterUserData {
    name: string;
    email: string;
    password: string;
    role: UserRole;
}
