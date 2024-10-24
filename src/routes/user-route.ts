import express, { Router } from 'express';
import {
  createUser,
  getAll,
  getUserById,
  updateUser,
} from '../controllers/user-controller';
const router: Router = express.Router();

router.get('/', getAll);
router.get('/:id', getUserById);
router.post('/create', createUser);
router.put('/update/:id', updateUser);
router.post('/delete/:id', createUser);

export default router;
