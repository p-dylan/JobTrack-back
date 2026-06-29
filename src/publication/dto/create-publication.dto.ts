import { IsBoolean, IsEnum, IsNotEmpty, IsNumber, IsString, MaxLength } from "class-validator";
import { publication_type } from "prisma/generated/prisma/enums";

export class CreatePublicationDto {

    @IsNotEmpty()
    @IsString()
    @MaxLength(255)
    title: string;

    @IsString()
    content: string;

    @IsNotEmpty()
    @IsEnum(publication_type)
    type: publication_type;

    @IsNotEmpty()
    @IsBoolean()
    is_public: boolean;


    @IsNumber()
    likes_count: number
}
