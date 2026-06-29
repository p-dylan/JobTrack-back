import { PartialType } from '@nestjs/mapped-types';
import { CreateJobOfferingDto } from './create-job_offering.dto';

export class UpdateJobOfferingDto extends PartialType(CreateJobOfferingDto) {}
