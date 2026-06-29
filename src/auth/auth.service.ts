import { Injectable, UnauthorizedException } from '@nestjs/common';
import { RegisterDto } from './dto/register.dto';
import { PrismaService } from 'prisma/prisma.service';
import { LoginDto } from './dto/Login.dto';
import { user } from 'prisma/generated/prisma/client';
import * as argon2 from 'argon2'

@Injectable()
export class AuthService {
  constructor(private readonly prisma: PrismaService) {}

  async signUp(dto: RegisterDto): Promise<Omit<user, 'password'>>{
    const hashedPassword = await argon2.hash(dto.password);

    return this.prisma.user.create({
      data: { ...dto, password: hashedPassword},
      omit: { password: true}
    });
  }


  async signIn(dto: LoginDto ): Promise<user> {
    const user = await this.prisma.user.findUnique({
      where: { email: dto.email},
    });

    if(!user) throw new UnauthorizedException('Identifiants invalides');

    const isValid = await argon2.verify(user.password, dto.password);
    if (!isValid) throw new UnauthorizedException('Identifiant invalide')
      return user


  }

  

  
}
