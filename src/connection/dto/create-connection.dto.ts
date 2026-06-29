import { IsEnum, IsNotEmpty } from "class-validator";
import { connection_status } from "prisma/generated/prisma/enums";

export class CreateConnectionDto {
    
    @IsNotEmpty()
    @IsEnum(connection_status)
    status: connection_status
}
