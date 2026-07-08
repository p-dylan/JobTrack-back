import { User } from "prisma/generated/prisma/client";

export type UserWithoutPass = Omit<User, "password">