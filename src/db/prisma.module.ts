import { Global, Module } from '@nestjs/common';
import { db } from './prisma.connection';

@Global()
@Module({
  providers: [
    {
      provide: 'PRISMA_CLIENT',
      useValue: db,
    },
  ],
  exports: ['PRISMA_CLIENT'],
})
export class PrismaModule {}
