import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  const clientOrigin = process.env.CLIENT_ORIGIN || 'http://localhost:3000';

  app.enableCors({
    origin: clientOrigin,
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    credentials: true
  });

  await app.listen(process.env.PORT || 3001, '0.0.0.0');
}
bootstrap();
