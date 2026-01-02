-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('ADMIN', 'ORANGTUA', 'PENDAMPING');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "UserRole" NOT NULL,
    "pendampingId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OrangTuaProfile" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "uniqueCode" TEXT NOT NULL,
    "usia" INTEGER NOT NULL,
    "riwayatPenyakit" TEXT[],
    "frekuensiOlahraga" TEXT,
    "sesakNapas" BOOLEAN,
    "tujuanOlahraga" TEXT,

    CONSTRAINT "OrangTuaProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PendampingProfile" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "usia" INTEGER NOT NULL,

    CONSTRAINT "PendampingProfile_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "OrangTuaProfile_userId_key" ON "OrangTuaProfile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "OrangTuaProfile_uniqueCode_key" ON "OrangTuaProfile"("uniqueCode");

-- CreateIndex
CREATE UNIQUE INDEX "PendampingProfile_userId_key" ON "PendampingProfile"("userId");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_pendampingId_fkey" FOREIGN KEY ("pendampingId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrangTuaProfile" ADD CONSTRAINT "OrangTuaProfile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PendampingProfile" ADD CONSTRAINT "PendampingProfile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
