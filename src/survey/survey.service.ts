import { Inject, Injectable } from '@nestjs/common';
import { PrismaClient } from 'prisma/generated/client';

@Injectable()
export class SurveyService {
  constructor(
    @Inject('PRISMA_CLIENT') private readonly db: PrismaClient, //generated PrismaClient import!!
  ) {}

  getAll() {
    return this.db.survey.findMany({
      select: {
        id: true,
        createdAt: true,
        title: true,
        age: true,
        term: true,
        isActive: true,
        IsMain: true,
      }
    });
  }
}
