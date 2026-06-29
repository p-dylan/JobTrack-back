import { IsEnum, IsNotEmpty, IsString, MaxLength } from "class-validator";
import { document_type } from "prisma/generated/prisma/enums";

export class CreateDocumentDto {

    @IsNotEmpty()
    @IsString()
    @MaxLength(255)
    title: string;

    @IsNotEmpty()
    @IsEnum(document_type)
    type: document_type;

    @IsString()
    @MaxLength(500)
    file_url: string
}
