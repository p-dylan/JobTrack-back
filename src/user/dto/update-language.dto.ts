import { IsNotEmpty, IsString, IsIn } from 'class-validator';

export class UpdateLanguageDto {
  @IsNotEmpty()
  @IsString()
  @IsIn(["fr", "en", "es", "de"])
  language: string;
}