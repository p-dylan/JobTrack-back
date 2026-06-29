import { Injectable } from '@nestjs/common';
import { CreateJobOfferingDto } from './dto/create-job_offering.dto';
import { UpdateJobOfferingDto } from './dto/update-job_offering.dto';

@Injectable()
export class JobOfferingService {
  create(createJobOfferingDto: CreateJobOfferingDto) {
    return 'This action adds a new jobOffering';
  }

  findAll() {
    return `This action returns all jobOffering`;
  }

  findOne(id: number) {
    return `This action returns a #${id} jobOffering`;
  }

  update(id: number, updateJobOfferingDto: UpdateJobOfferingDto) {
    return `This action updates a #${id} jobOffering`;
  }

  remove(id: number) {
    return `This action removes a #${id} jobOffering`;
  }
}
