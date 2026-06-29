
import { ConflictException, Injectable, NotFoundException } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { Prisma, user } from 'prisma/generated/prisma/client';
import { PrismaService } from 'prisma/prisma.service';



@Injectable()
export class UserService {
  constructor(private readonly prisma: PrismaService) {}


  async create(dto: CreateUserDto): Promise<user> {

    const isEmail = await this.prisma.user.findUnique({ where: { email: dto.email } });
    if (isEmail) throw new ConflictException('Email already used !!!');
    return this.prisma.user.create({ 
      data: {
        ...dto,
        role: {connect: { name: dto.role}}
      }
      
     });
  }

  async findOne(id: number): Promise<user> {
    const user = await this.prisma.user.findUnique({ where: { id } });
    if (!user) throw new NotFoundException(`User with id: ${id} not found`);
    return user;
  }

  async findAll(): Promise<user[]> {
    return this.prisma.user.findMany();
  }

  async findByEmail(email: string): Promise<user> {
    return this.prisma.user.findUniqueOrThrow({ where: { email } });
  }

  async update(id: number, dto: UpdateUserDto): Promise<user> {
    await this.findOne(id);

    if (dto.email) {
      const existing = await this.prisma.user.findUnique({ where: { email: dto.email } });
      if (existing && existing.id !== id) {
        throw new ConflictException('Cet email est déja utilisé');
      }
    }

    const { role, ...rest } = dto;

  return this.prisma.user.update({
    where: { id },
    data: {
      ...rest,
      ...(role && { role: { connect: { name: role } } }),
    },
  });
  }
  

  async delete(id: number): Promise<user> {
    await this.findOne(id);
    return this.prisma.user.delete({ where: { id }});
  }

  async deleteAll(): Promise<Prisma.BatchPayload> {
    const result = await this.prisma.user.deleteMany()
    await this.prisma.$executeRaw `ALTER TABLE User AUTO_INCREMENT = 1`;
    await this.prisma.$executeRaw `ALTER TABLE Candidate AUTO_INCREMENT = 1`;
    await this.prisma.$executeRaw `ALTER TABLE Recruiter AUTO_INCREMENT = 1`;

    return result;
  }
}
