import { IsEnum, IsNotEmpty, IsString } from "class-validator";
import { application_status } from "prisma/generated/prisma/enums";

export class CreateApplicationDto {

    @IsNotEmpty()
    @IsEnum(application_status)
    status: application_status;
}
