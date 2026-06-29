import { Module } from '@nestjs/common';
import { JobOfferingService } from './job_offering.service';
import { JobOfferingController } from './job_offering.controller';

@Module({
  controllers: [JobOfferingController],
  providers: [JobOfferingService],
})
export class JobOfferingModule {}
