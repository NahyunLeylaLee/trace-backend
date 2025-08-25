/*
  Warnings:

  - You are about to drop the column `IsBasic` on the `Survey` table. All the data in the column will be lost.
  - You are about to drop the column `IsMain` on the `Survey` table. All the data in the column will be lost.
  - You are about to drop the column `age` on the `Survey` table. All the data in the column will be lost.
  - You are about to drop the column `description` on the `Survey` table. All the data in the column will be lost.
  - You are about to drop the column `invalidAt` on the `Survey` table. All the data in the column will be lost.
  - You are about to drop the column `isActive` on the `Survey` table. All the data in the column will be lost.
  - You are about to drop the column `order` on the `Survey` table. All the data in the column will be lost.
  - You are about to drop the column `startSending` on the `Survey` table. All the data in the column will be lost.
  - You are about to drop the column `term` on the `Survey` table. All the data in the column will be lost.

*/
-- CreateEnum
CREATE TYPE "public"."SurveyStatus" AS ENUM ('DRAFT', 'ACTIVE', 'ARCHIVED');

-- CreateEnum
CREATE TYPE "public"."QuestionType" AS ENUM ('TEXT_VIEW', 'SHORT_ANSWER', 'LONG_ANSWER', 'NUMERIC_ANSWER', 'BLANK_ANSWER', 'MULTIPLE_CHOICE', 'CHECKBOXES', 'DROP_DOWN', 'DROP_DOWN_RANGE', 'LINEAR_SCALE', 'RADIO_GRID', 'CHECKBOX_GRID', 'DATE_ANSWER', 'YEAR_ANSWER', 'TIME_ANSWER', 'TIMETABLE', 'FILE_UPLOAD', 'ADDRESS_ANSWER');

-- CreateEnum
CREATE TYPE "public"."OptionAxis" AS ENUM ('ROW', 'COLUMN');

-- AlterTable
ALTER TABLE "public"."Survey" DROP COLUMN "IsBasic",
DROP COLUMN "IsMain",
DROP COLUMN "age",
DROP COLUMN "description",
DROP COLUMN "invalidAt",
DROP COLUMN "isActive",
DROP COLUMN "order",
DROP COLUMN "startSending",
DROP COLUMN "term",
ADD COLUMN     "activatedAt" TIMESTAMP(3),
ADD COLUMN     "status" "public"."SurveyStatus" NOT NULL DEFAULT 'ARCHIVED',
ADD COLUMN     "version" TEXT NOT NULL DEFAULT 'v1';

-- CreateTable
CREATE TABLE "public"."Section" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "order" INTEGER NOT NULL,
    "surveyId" INTEGER NOT NULL,

    CONSTRAINT "Section_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Question" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "type" "public"."QuestionType" NOT NULL,
    "title" TEXT NOT NULL,
    "alias" TEXT,
    "guide" TEXT,
    "order" INTEGER NOT NULL,
    "minimum" TEXT,
    "maximum" TEXT,
    "isRequired" BOOLEAN NOT NULL,
    "sectionId" INTEGER NOT NULL,

    CONSTRAINT "Question_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."QuestionCondition" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "operator" TEXT NOT NULL DEFAULT '=',
    "value" TEXT NOT NULL,
    "questionId" INTEGER NOT NULL,

    CONSTRAINT "QuestionCondition_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Option" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "axis" "public"."OptionAxis" NOT NULL DEFAULT 'ROW',
    "order" INTEGER NOT NULL,
    "isDefault" BOOLEAN NOT NULL DEFAULT false,
    "score" INTEGER,
    "questionId" INTEGER NOT NULL,

    CONSTRAINT "Option_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Answer" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "text" TEXT,
    "questionId" INTEGER NOT NULL,
    "rowId" INTEGER NOT NULL,
    "colId" INTEGER NOT NULL,
    "historyId" INTEGER NOT NULL,

    CONSTRAINT "Answer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."SurveyHistory" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiredAt" TIMESTAMP(3),
    "isComplete" BOOLEAN NOT NULL DEFAULT false,
    "surveyId" INTEGER NOT NULL,
    "senderId" INTEGER NOT NULL,
    "receiverId" INTEGER NOT NULL,

    CONSTRAINT "SurveyHistory_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public"."Section" ADD CONSTRAINT "Section_surveyId_fkey" FOREIGN KEY ("surveyId") REFERENCES "public"."Survey"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Question" ADD CONSTRAINT "Question_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "public"."Section"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."QuestionCondition" ADD CONSTRAINT "QuestionCondition_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES "public"."Question"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Option" ADD CONSTRAINT "Option_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES "public"."Question"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Answer" ADD CONSTRAINT "Answer_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES "public"."Question"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Answer" ADD CONSTRAINT "Answer_rowId_fkey" FOREIGN KEY ("rowId") REFERENCES "public"."Option"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Answer" ADD CONSTRAINT "Answer_colId_fkey" FOREIGN KEY ("colId") REFERENCES "public"."Option"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Answer" ADD CONSTRAINT "Answer_historyId_fkey" FOREIGN KEY ("historyId") REFERENCES "public"."SurveyHistory"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."SurveyHistory" ADD CONSTRAINT "SurveyHistory_surveyId_fkey" FOREIGN KEY ("surveyId") REFERENCES "public"."Survey"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
