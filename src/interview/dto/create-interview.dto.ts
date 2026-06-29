import { IsDate, IsEnum, IsNotEmpty, IsOptional, IsString } from "class-validator";
import { interview_interview_type } from "prisma/generated/prisma/client";

export class CreateInterviewDto {

    @IsNotEmpty()
    @IsDate()
    scheduled_at: Date;

    @IsNotEmpty()
    @IsString()
    @IsEnum(interview_interview_type)
    interview_type: interview_interview_type

    @IsNotEmpty()
    @IsOptional()
    @IsString()
    notes?: string
}
