import {IsEnum, IsNotEmpty, IsString, MaxLength } from "class-validator";
import { job_offering_contract_type } from "prisma/generated/prisma/enums";

export class CreateJobOfferingDto {

    @IsNotEmpty()
    @IsString()
    @MaxLength(255)
    title: string;

    @IsNotEmpty()
    @IsString()
    description: string;

    @IsNotEmpty()
    @IsEnum(job_offering_contract_type)
    contract_type: job_offering_contract_type;

}
