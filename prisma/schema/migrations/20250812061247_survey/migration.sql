-- CreateTable
CREATE TABLE "public"."Survey" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "age" INTEGER NOT NULL,
    "term" INTEGER NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "invalidAt" TIMESTAMP(3),
    "order" INTEGER NOT NULL,
    "IsMain" BOOLEAN NOT NULL DEFAULT false,
    "IsBasic" BOOLEAN NOT NULL DEFAULT false,
    "startSending" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Survey_pkey" PRIMARY KEY ("id")
);
