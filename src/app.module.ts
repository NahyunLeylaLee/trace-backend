import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './db/prisma.module';
import { SurveyController } from './survey/survey.controller';
import { SurveyService } from './survey/survey.service';
import { SurveyModule } from './survey/survey.module';

@Module({
  imports: [
    PrismaModule,
    SurveyModule
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}