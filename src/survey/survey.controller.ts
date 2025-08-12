import { Controller, Get } from '@nestjs/common';
import { SurveyService } from './survey.service';

@Controller('survey')
export class SurveyController {
  constructor(private readonly service: SurveyService) {}

  @Get()
  getAll() {
    return this.service.getAll();
  }

}
