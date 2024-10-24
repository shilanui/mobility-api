import express, { Router } from 'express';
import {
  getAll,
  getNotiByAgentId,
} from '../controllers/notification-controller';
const router: Router = express.Router();

router.get('/', getAll);
router.get('/:id', getNotiByAgentId);
router.post('/create', getNotiByAgentId);

export default router;
