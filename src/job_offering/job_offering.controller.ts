import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { JobOfferingService } from './job_offering.service';
import { CreateJobOfferingDto } from './dto/create-job_offering.dto';
import { UpdateJobOfferingDto } from './dto/update-job_offering.dto';

@Controller('job-offering')
export class JobOfferingController {
  constructor(private readonly jobOfferingService: JobOfferingService) {}

  @Post()
  create(@Body() createJobOfferingDto: CreateJobOfferingDto) {
    return this.jobOfferingService.create(createJobOfferingDto);
  }

  @Get()
  findAll() {
    return this.jobOfferingService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.jobOfferingService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateJobOfferingDto: UpdateJobOfferingDto) {
    return this.jobOfferingService.update(+id, updateJobOfferingDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.jobOfferingService.remove(+id);
  }
}
