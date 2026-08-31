import {
  IsString,
  IsEmail,
  IsNotEmpty,
  IsStrongPassword,
  MaxLength,
} from 'class-validator';

export class CreateUserDto {
  @IsNotEmpty()
  @IsString()
  @MaxLength(100)
  first_name: string;

  @IsNotEmpty()
  @IsString()
  @MaxLength(100)
  last_name: string;

  @IsEmail()
  @MaxLength(255)
  email: string;

  @IsStrongPassword({
    minLength: 8,
    minUppercase: 1,
    minNumbers: 1,
    minSymbols: 1,
  })
  @MaxLength(255)
  password: string;
}
